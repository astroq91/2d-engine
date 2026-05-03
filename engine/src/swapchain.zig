const std = @import("std");
const GraphicsContext = @import("graphics_context.zig").GraphicsContext;
const Allocator = std.mem.Allocator;
const vk = @import("vulkan");
const Window = @import("window.zig").Window;
const Image = @import("image.zig").Image;

pub const Swapchain = struct {
    gc: *const GraphicsContext,
    allocator: Allocator,

    handle: vk.SwapchainKHR,
    images: []vk.Image,
    image_views: []vk.ImageView,
    depth_imagei: vk.Image,
    pub fn init(gc: *const GraphicsContext, allocator: Allocator, window: *const Window) !Swapchain {
        var self: Swapchain = undefined;
        self.gc = gc;
        self.allocator = allocator;

        self.handle = try createSwapchain(gc, window); 
        self.images = try gc.dev.getSwapchainImagesAllocKHR(self.handle, allocator);

        return self;
    }

    pub fn deinit(self: *Swapchain) void {
        self.allocator.free(self.image_views);
        self.allocator.free(self.images);

        self.gc.dev.destroySwapchainKHR(self.handle, null);
    }

};

fn createSwapchain(gc: *const GraphicsContext, window: *const Window) !vk.SwapchainKHR {
    const surface_caps = gc.surface_capabilities;
    const extent: vk.Extent2D = 
        if (surface_caps.current_extent.width == std.math.maxInt(u32) and
            surface_caps.current_extent.height == std.math.maxInt(u32)) 
            vk.Extent2D {
                .width = window.width(),
                .height = window.height(),
            }
         else 
            gc.surface_capabilities.current_extent;
        

    const image_format = vk.Format.b8g8r8a8_srgb;
    const info = vk.SwapchainCreateInfoKHR {
        .surface = gc.surface,
        .min_image_count = surface_caps.min_image_count,
        .image_format = image_format,
        .image_color_space = vk.ColorSpaceKHR.srgb_nonlinear_khr,
        .clipped = .false,
        .image_sharing_mode = .exclusive,
        .image_extent = .{
            .width = extent.width,
            .height = extent.height,
        },
        .image_array_layers = 1,
        .image_usage = .{ .color_attachment_bit = true },
        .pre_transform = .{ .identity_bit_khr = true },
        .composite_alpha = .{ .opaque_bit_khr = true },
        .present_mode = .fifo_khr,
    };
    return try gc.dev.createSwapchainKHR(&info, null);
}

fn createDepthImage(gc: *const GraphicsContext, extent: vk.Extent2D) !Image {
    const info = vk.ImageCreateInfo {
        .image_type = .@"2d",
        .format = pickDepthFormat(gc),
        .extent = extent,
        .mip_levels = 1,
        .array_layers = 1,
        .samples = .{ .@"1_bit" = true },
        .tiling = .optimal,
        .usage = .{ .depth_stencil_attachment_bit = true },
        .initial_layout = .undefined,
    };

    return try Image.init(gc, info);
}

fn pickDepthFormat(gc: *const GraphicsContext) !vk.Format {
    const formats = [_]vk.Format{ vk.Format.d32_sfloat_s8_uint, vk.Format.d24_unorm_s8_uint }; 
    for (formats) |format| {
        const props: vk.FormatProperties2 = undefined;
        gc.instance.getPhysicalDeviceFormatProperties2(gc.pdev, format, &props);
        if (props.format_properties.optimal_tiling_features.depth_stencil_attachment_bit) {
            return format;
        }
    }

    return error.NoAvailableDepthFormat;
}
