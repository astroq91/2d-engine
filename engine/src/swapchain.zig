const std = @import("std");
const GraphicsContext = @import("graphics_context.zig").GraphicsContext;
const vk = @import("vulkan");
const Window = @import("window.zig").Window;

pub const Swapchain = struct {
    handle: vk.SwapchainKHR,
    pub fn init(gc: GraphicsContext, window: *Window) !Swapchain {
        var self: Swapchain = undefined;
        const extent: vk.Extent2D = 
            if (gc.surface_capabilities.current_extent == 0xFFFFFFFF) {
                vk.Extent2D {
                    .width = window.width(),
                    .height = window.height()
                };
            } else {
                gc.surface_capabilities.current_extent;
            };
        return self;
    }
};
