const vk = @import("vulkan");
const std = @import("std");
const window = @import("window.zig").Window;

pub fn init() !void {
    var win = try window.init();
    defer win.deinit();
    while (true) {}
}
