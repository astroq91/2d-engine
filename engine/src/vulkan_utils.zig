const std = @import("std");
const vk = @import("vulkan");
const GraphicsContext = @import("graphics_context.zig").GraphicsContext;

pub fn findMemoryType(gc: *const GraphicsContext, type_filter: u32, properties: vk.MemoryPropertyFlags) !u32 {
    const mem_props = gc.instance.getPhysicalDeviceMemoryProperties(gc.pdev);
    for (0..mem_props.memory_type_count) |i| {
        if ((type_filter & (1 << i)) and (mem_props.memory_types[i].property_flags & properties) == properties) {
            return i;
        } 
    } 
    return error.NoAvailableMemoryType;
}
