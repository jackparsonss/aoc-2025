const std = @import("std");

const path = "data/day3.txt";

pub fn day3p1() !void {
    var file = try std.fs.cwd().openFile(path, .{});
    defer file.close();

    var buf: [32768]u8 = undefined;
    const re = try file.read(&buf);
    var buf_reader = std.io.fixedBufferStream(buf[0..re]);
    var in_stream = buf_reader.reader();

    var sum: i32 = 0;
    while (try in_stream.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        var l: usize = 0;
        var r: usize = 1;
        const n = line.len;
        var max: i32 = 0;

        while (r < n) {
            const ll = line[l] - '0';
            const lr = line[r] - '0';

            const j = ll * 10 + lr;
            max = @max(max, j);

            if (r < n - 1 and lr >= ll) {
                l = r;
            }

            r += 1;
        }

        sum += max;
    }

    std.debug.print("Day 3, Part 1: {}\n", .{sum});
}

pub fn day3p2() !void {}
