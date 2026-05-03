const std = @import("std");
const GraphicsContext = @import("graphics_context.zig").GraphicsContext;
const Allocator = std.mem.Allocator;
const vk = @import("vulkan");
const vk_utils = @import("vulkan_utils.zig");

const Image = struct {
    gc: *const GraphicsContext,

    handle: vk.Image,
    memory: vk.DeviceMemory,
    pub fn init(gc: *const GraphicsContext, info: *const vk.ImageCreateInfo, properties: *const vk.MemoryPropertyFlags) !Image {
        var self: Image = undefined;
        self.gc = gc;

        self.handle = try gc.dev.createImage(info, null); 
        const requirements = gc.dev.getImageMemoryRequirements(self.handle);
        const alloc_info = vk.MemoryAllocateInfo {
            .allocation_size = requirements.size,
            .memory_type_index = try vk_utils.findMemoryType(gc, requirements.memory_type_bits, properties),
        };
        self.memory = try gc.dev.allocateMemory(&alloc_info, null);
        gc.dev.bindImageMemory(self.handle, self.memory, 0);

        return self;
    }

    pub fn deinit(self: *Image) void {
        self.gc.dev.destroyImage(self.handle, null);
        self.gc.dev.freeMemory(self.memory, null);
    }
};
