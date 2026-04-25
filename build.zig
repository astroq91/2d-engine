const std = @import("std");

pub fn build(b: *std.Build) void {
    const sandbox = b.dependency("sandbox", .{});

    const run_step = b.step("run", "Run the app");
    
    const run_cmd = b.addRunArtifact(sandbox.artifact("sandbox"));
    run_step.dependOn(&run_cmd.step);

    run_cmd.step.dependOn(b.getInstallStep());
}
