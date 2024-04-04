const std = @import("std");
const code_reminder_build = @import("code_reminder");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "main",
        .target = target,
        .optimize = optimize,
        .root_source_file = .{ .path = "main.zig" },
    });

    _ = code_reminder_build.importModule(b, exe);

    b.installArtifact(exe);
}
