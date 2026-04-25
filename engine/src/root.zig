const c = @import("c.zig");
const vk = @import("vulkan");

pub fn init() !void {
    if (c.glfwInit() != c.GLFW_TRUE) return error.GlfwInitFailed;
    defer c.glfwTerminate();

    const extent = vk.Extent2D{ .width = 800, .height = 600 };
    c.glfwWindowHint(c.GLFW_CLIENT_API, c.GLFW_NO_API);
    const window = c.glfwCreateWindow(
        @intCast(extent.width),
        @intCast(extent.height),
        "Engine",
        null,
        null
    ) orelse return error.WindowInitFailed;
    defer c.glfwDestroyWindow(window);
    while (true) {}
}
