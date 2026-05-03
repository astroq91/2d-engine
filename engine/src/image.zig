const std = @import("std");
const GraphicsContext = @import("graphics_context.zig").GraphicsContext;
const Allocator = std.mem.Allocator;
const vk = @import("vulkan");

const Image = struct {
    handle: vk.Image,
    memory: vk.DeviceMemory,
    pub fn init(gc: *const GraphicsContext, info: *const vk.ImageCreateInfo) !Image {
        var self: Image = undefined;
        self.handle = try gc.dev.createImage(info, null); 

        // TODO: Allocate memory
        return self;
    }
};
