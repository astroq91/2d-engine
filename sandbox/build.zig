const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    
    const exe = b.addExecutable(.{
        .name = "sandbox",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/main.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });

    const engine_dep = b.dependency("engine", .{});
    exe.root_module.linkLibrary(engine_dep.artifact("engine"));
    exe.root_module.addImport("engine", engine_dep.module("engine"));
    exe.root_module.linkSystemLibrary("glfw", .{});

    b.installArtifact(exe);
}
