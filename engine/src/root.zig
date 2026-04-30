const vk = @import("vulkan");
const std = @import("std");
const Window = @import("window.zig").Window;
const GraphicsContext = @import("graphics_context.zig").GraphicsContext;
const Swapchain = @import("swapchain.zig").Swapchain;
const Allocator = std.mem.Allocator;

pub fn init(allocator: Allocator, update_fn: *const fn () void) !void {
    var window = try Window.init();
    defer window.deinit();
    var graphics_context = try GraphicsContext.init(allocator, "engine", window.handle);
    defer graphics_context.deinit();
    while (true) {
        update_fn();
    }
}
