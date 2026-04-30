const std = @import("std");
const vk = @import("vk");
const Io = std.Io;

const engine = @import("engine");

pub fn main(init: std.process.Init) !void {
    try engine.init(init.gpa, onUpdate);
}

fn onUpdate() void {}
