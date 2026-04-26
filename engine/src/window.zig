const c = @import("c.zig");
const vk = @import("vulkan");
const std = @import("std");

pub const Window = struct {
    handle: *c.GLFWwindow,
    pub fn init() !Window {
        var self: Window = undefined;
        if (c.glfwInit() != c.GLFW_TRUE) return error.GlfwInitFailed;
        c.glfwWindowHint(c.GLFW_CLIENT_API, c.GLFW_NO_API);

        const extent = vk.Extent2D{ .width = 800, .height = 600 };
        self.handle = c.glfwCreateWindow(
            @intCast(extent.width),
            @intCast(extent.height),
            "Engine",
            null,
            null
        ) orelse return error.WindowInitFailed;

        std.debug.print("Window initialized!", .{});
        return self;
    }

    pub fn deinit(self: *Window) void {
        c.glfwTerminate();
        c.glfwDestroyWindow(self.handle);
    }
};
