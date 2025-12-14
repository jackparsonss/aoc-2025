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

pub fn day3p2() !void {
    var file = try std.fs.cwd().openFile(path, .{});
    defer file.close();

    var buf: [32768]u8 = undefined;
    const re = try file.read(&buf);
    var buf_reader = std.io.fixedBufferStream(buf[0..re]);
    var in_stream = buf_reader.reader();

    var sum: u64 = 0;
    while (try in_stream.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        const n = line.len;
        const batteries_to_pick = 12;

        var result: u64 = 0;
        var start_pos: usize = 0;
        var remaining: usize = batteries_to_pick;

        while (remaining > 0) {
            const end_pos = n - remaining;

            var max_digit: u8 = line[start_pos];
            var max_pos: usize = start_pos;

            var pos = start_pos;
            while (pos <= end_pos) : (pos += 1) {
                if (line[pos] > max_digit) {
                    max_digit = line[pos];
                    max_pos = pos;
                }
            }

            result = result * 10 + (max_digit - '0');
            start_pos = max_pos + 1;
            remaining -= 1;
        }

        sum += result;
    }

    std.debug.print("Day 3, Part 2: {}\n", .{sum});
}
