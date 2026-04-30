const std = @import("std");

pub fn build(b: *std.Build) void {
    const lib = b.addModule("vulkan", .{
        .root_source_file = b.path("vk.zig")
    });
    _ = lib;
}
