const std = @import("std");
const vk = @import("vk");
const Io = std.Io;

const engine = @import("engine");

pub fn main(init: std.process.Init) !void {
    try engine.init(init.gpa);
    // Prints to stderr, unbuffered, ignoring potential errors.
    std.debug.print("Hello world!\n", .{});
}
