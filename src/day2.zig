const std = @import("std");

const path = "data/day2.txt";

pub fn day2p1() !void {
    var b: [4096]u8 = undefined;
    var a = std.heap.FixedBufferAllocator.init(&b);
    const allocator = a.allocator();

    var file = try std.fs.cwd().openFile(path, .{});
    defer file.close();

    var buf: [4096]u8 = undefined;
    const r = try file.read(&buf);
    var buf_reader = std.io.fixedBufferStream(buf[0..r]);
    var in_stream = buf_reader.reader();

    var total: usize = 0;
    while (try in_stream.readUntilDelimiterOrEof(&buf, ',')) |line| {
        const trimmed = std.mem.trim(u8, line, &std.ascii.whitespace);
        var it = std.mem.splitScalar(u8, trimmed, '-');

        const s = it.next().?;
        const e = it.next().?;

        const start = try std.fmt.parseInt(usize, s, 10);
        const end = try std.fmt.parseInt(usize, e, 10);

        for (start..end + 1) |v| {
            const str = try std.fmt.allocPrint(allocator, "{d}", .{v});
            defer allocator.free(str);

            const len = str.len / 2;
            if (std.mem.eql(u8, str[0..len], str[len..])) {
                total += v;
            }
        }
    }

    std.debug.print("Day 2, Part 1: {}\n", .{total});
}

pub fn day2p2() !void {
    var file = try std.fs.cwd().openFile(path, .{});
    defer file.close();

    var buf: [4096]u8 = undefined;
    const r = try file.read(&buf);
    var buf_reader = std.io.fixedBufferStream(buf[0..r]);
    var in_stream = buf_reader.reader();

    var total: usize = 0;
    while (try in_stream.readUntilDelimiterOrEof(&buf, ',')) |line| {
        const trimmed = std.mem.trim(u8, line, &std.ascii.whitespace);
        var it = std.mem.splitScalar(u8, trimmed, '-');

        const s = it.next().?;
        const e = it.next().?;

        const start = try std.fmt.parseInt(usize, s, 10);
        const end = try std.fmt.parseInt(usize, e, 10);

        for (start..end + 1) |v| {
            var str_buf: [32]u8 = undefined;
            const str = try std.fmt.bufPrint(&str_buf, "{d}", .{v});

            const len = str.len / 2;
            for (1..len + 1) |patternLen| {
                if (str.len % patternLen != 0) {
                    continue;
                }

                const pattern = str[0..patternLen];
                const repeatCount = str.len / patternLen;
                if (repeatCount < 2) {
                    continue;
                }

                var matches = true;
                for (1..repeatCount) |i| {
                    const segment = str[i * patternLen .. (i + 1) * patternLen];
                    if (!std.mem.eql(u8, pattern, segment)) {
                        matches = false;
                        break;
                    }
                }
                if (matches) {
                    total += v;
                    break;
                }
            }
        }
    }

    std.debug.print("Day 2, Part 2: {}\n", .{total});
}
