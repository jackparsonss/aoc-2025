const std = @import("std");

const path = "data/day4.txt";

const size = 140;

pub fn day4p1() !void {
    var file = try std.fs.cwd().openFile(path, .{});
    defer file.close();

    var buf: [32768]u8 = undefined;
    const re = try file.read(&buf);
    var buf_reader = std.io.fixedBufferStream(buf[0..re]);
    var in_stream = buf_reader.reader();

    var inei: usize = 0;
    var data: [size][size]u8 = undefined;
    while (try in_stream.readUntilDelimiterOrEof(&buf, '\n')) |ine| {
        for (ine, 0..) |c, j| {
            data[inei][j] = c;
        }

        inei += 1;
    }

    var total: u32 = 0;
    for (0..size) |i| {
        for (0..size) |j| {
            const c = data[i][j];
            if (c != '@') {
                continue;
            }

            const li: i32 = @intCast(i);
            const lj: i32 = @intCast(j);
            var count: u32 = 0;
            if (li - 1 >= 0 and data[@intCast(li - 1)][j] == '@') {
                count += 1;
            }

            if (li + 1 < size and data[@intCast(li + 1)][j] == '@') {
                count += 1;
            }

            if (lj - 1 >= 0 and data[i][@intCast(lj - 1)] == '@') {
                count += 1;
            }

            if (lj + 1 < size and data[i][@intCast(lj + 1)] == '@') {
                count += 1;
            }

            if (li - 1 >= 0 and lj - 1 >= 0 and data[@intCast(li - 1)][@intCast(lj - 1)] == '@') {
                count += 1;
            }

            if (li + 1 < size and lj - 1 >= 0 and data[@intCast(li + 1)][@intCast(lj - 1)] == '@') {
                count += 1;
            }

            if (li - 1 >= 0 and lj + 1 < size and data[@intCast(li - 1)][@intCast(lj + 1)] == '@') {
                count += 1;
            }

            if (li + 1 < size and lj + 1 < size and data[@intCast(li + 1)][@intCast(lj + 1)] == '@') {
                count += 1;
            }

            if (count < 4) {
                total += 1;
            }
        }
    }

    std.debug.print("Day 4, Part 1: {}\n", .{total});
}

pub fn day4p2() !void {}
