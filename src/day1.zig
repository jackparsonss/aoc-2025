const std = @import("std");

const path = "data/day1.txt";

pub fn day1p1() !void {
    var file = try std.fs.cwd().openFile(path, .{});
    defer file.close();

    var buf: [32768]u8 = undefined;
    const r = try file.read(&buf);
    var buf_reader = std.io.fixedBufferStream(buf[0..r]);
    var in_stream = buf_reader.reader();

    var start: i32 = 50;
    var count: i32 = 0;
    while (try in_stream.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        const value = try std.fmt.parseInt(i32, line[1..], 10);
        switch (line[0]) {
            'L' => {
                start = @mod(start - value, 100);
            },
            'R' => {
                start = @mod(start + value, 100);
            },
            else => unreachable,
        }

        if (start == 0) {
            count += 1;
        }
    }

    std.debug.print("Day 1, Part 1: {}\n", .{count});
}

pub fn day1p2() !void {
    var file = try std.fs.cwd().openFile(path, .{});
    defer file.close();

    var buf: [32768]u8 = undefined;
    const re = try file.read(&buf);
    var buf_reader = std.io.fixedBufferStream(buf[0..re]);
    var in_stream = buf_reader.reader();

    var start: i32 = 50;
    var count: u32 = 0;
    while (try in_stream.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        const value = try std.fmt.parseInt(i32, line[1..], 10);
        switch (line[0]) {
            'L' => {
                const base_crosses: i32 = @divTrunc(value - start, 100);
                const crosses = @as(u32, @intCast(@max(0, base_crosses))) +
                    if (start > 0 and value >= start) @as(u32, 1) else 0;
                count += crosses;
                start = @mod(start - value, 100);
            },
            'R' => {
                count += @as(u32, @intCast(@divTrunc(start + value, 100)));
                start = @mod(start + value, 100);
            },
            else => unreachable,
        }
    }

    std.debug.print("Day 1, Part 2: {}\n", .{count});
}
