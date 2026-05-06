const std = @import("std");
const vk = @import("vulkan");
const GraphicsContext = @import("graphics_context.zig").GraphicsContext;

pub fn findMemoryType(gc: *const GraphicsContext, type_filter: u32, properties: vk.MemoryPropertyFlags) !u32 {
    const mem_props = gc.instance.getPhysicalDeviceMemoryProperties(gc.pdev);
    var i: u5 = 0; // 0..31
    while (i < mem_props.memory_type_count) : (i += 1) {
        if ((type_filter & (@as(u32, 1) << i) > 0) and (mem_props.memory_types[i].property_flags.contains(properties))) {
            return i;
        } 
    } 
    return error.NoAvailableMemoryType;
}
