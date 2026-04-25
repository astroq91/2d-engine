const std = @import("std");
const vk = @import("vk");
const Io = std.Io;

const engine = @import("engine");

pub fn main(_: std.process.Init) !void {
    
    try engine.init();
    // Prints to stderr, unbuffered, ignoring potential errors.
    std.debug.print("Hello world!\n", .{});
}
