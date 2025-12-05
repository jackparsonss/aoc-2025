const std = @import("std");

fn processLines(filename: []const u8, line_processor: fn ([]u8) void) !void {
    var file = try std.fs.cwd().openFile(filename, .{});
    defer file.close();

    var buf: [1024]u8 = undefined;
    const r = try file.read(&buf);
    var buf_reader = std.io.fixedBufferStream(buf[0..r]);
    var in_stream = buf_reader.reader();

    while (try in_stream.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        line_processor(line);
    }
}

const day1 = struct {
    fn p1(line: []u8) void {
        std.debug.print("{s}\n", .{line});
    }

    fn p2(line: []u8) void {
        std.debug.print("{s}\n", .{line});
    }
};

pub fn day1p1() !void {
    try processLines("data/day1.txt", day1.p1);
}

pub fn day1p2() !void {
    try processLines("data/day1.txt", day1.p2);
}
