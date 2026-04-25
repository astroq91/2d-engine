const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    
    const engine = b.addModule("engine", .{
        .root_source_file = b.path("src/root.zig"),
        .target = target,
        .optimize = optimize,
    });
    const lib = b.addLibrary(.{
        .name = "engine",
        .root_module = engine,
    });

    const vk_mod = b.addModule("vulkan", .{
        .target = target,
        .optimize = optimize,
        .root_source_file = b.path("../lib/vk.zig"),
    });

    lib.root_module.addImport("vulkan", vk_mod);
    lib.root_module.linkSystemLibrary("glfw", .{});
    b.installArtifact(lib);
}
