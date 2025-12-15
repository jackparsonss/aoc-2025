const std = @import("std");

const path = "data/testing.txt";

const split = 5;

const Range = struct {
    start: u64,
    end: u64,
};

pub fn day5p1() !void {
    var file = try std.fs.cwd().openFile(path, .{});
    defer file.close();

    var buf: [32768]u8 = undefined;
    const re = try file.read(&buf);
    var buf_reader = std.io.fixedBufferStream(buf[0..re]);
    var in_stream = buf_reader.reader();

    var i: u64 = 0;
    var count: u64 = 0;
    var data: [split - 1]Range = undefined;
    while (try in_stream.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        i += 1;
        if (i == split) {
            continue;
        }

        if (i < split) {
            const trimmed = std.mem.trim(u8, line, &std.ascii.whitespace);
            var it = std.mem.splitScalar(u8, trimmed, '-');

            const start = try std.fmt.parseInt(u64, it.next().?, 10);
            const end = try std.fmt.parseInt(u64, it.next().?, 10);
            data[i - 1] = Range{
                .start = start,
                .end = end,
            };
        } else {
            const val = try std.fmt.parseInt(u64, line, 10);
            for (0..split - 1) |it| {
                const r = data[it];
                if (val >= r.start and val <= r.end) {
                    count += 1;
                    break;
                }
            }
        }
    }
    std.debug.print("Day 5, Part 1: {}\n", .{count});
}

pub fn day5p2() !void {
    var file = try std.fs.cwd().openFile(path, .{});
    defer file.close();

    var buf: [32768]u8 = undefined;
    const re = try file.read(&buf);
    var buf_reader = std.io.fixedBufferStream(buf[0..re]);
    var in_stream = buf_reader.reader();

    var i: u64 = 0;
    var count: u64 = 0;
    var data: [split - 1]Range = undefined;
    while (try in_stream.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        i += 1;
        if (i == split) {
            break;
        }

        const trimmed = std.mem.trim(u8, line, &std.ascii.whitespace);
        var it = std.mem.splitScalar(u8, trimmed, '-');

        const start = try std.fmt.parseInt(u64, it.next().?, 10);
        const end = try std.fmt.parseInt(u64, it.next().?, 10);
        data[i - 1] = Range{
            .start = start,
            .end = end,
        };
    }

    std.debug.print("Day 5, Part 2: {}\n", .{count});
}
