const std = @import("std");
const code_reminder_build = @import("code_reminder");
const code_reminder = code_reminder_build.code_reminder;

const CodeReminderAsError = error{ MyTodoBuildUtil, Foo, Bar };

const CodeReminders = struct {
    MyTodoBuildUtil: code_reminder.CodeReminder,
    Foo: code_reminder.CodeReminder,
    Bar: code_reminder.CodeReminder,

    pub fn init(options: code_reminder.CodeReminderOptions) CodeReminders {
        return .{
            .MyTodoBuildUtil = code_reminder.CodeReminder.buildInit(options, null, CodeReminderAsError.MyTodoBuildUtil),
            .Foo = code_reminder.CodeReminder.buildInit(options, 12345, CodeReminderAsError.Foo),
            .Bar = code_reminder.CodeReminder.buildInit(options, null, CodeReminderAsError.Bar),
        };
    }
};

fn buildUtilFunctionToBeReplaced(b: *std.Build, cr: *const CodeReminders) void {
    _ = &b;
    cr.MyTodoBuildUtil.buildCheck(b, @src(), "Replace this function with 'newBuildUtilFunctionToUse'");
}

fn newBuildUtilFunctionToUse(b: *std.Build, cr: *CodeReminders) void {
    _ = &b;
    _ = &cr;

    //stubbed
}

fn foo(b: *std.Build, cr: *const CodeReminders) void {
    _ = &b;
    cr.Foo.buildCheck(b, @src(), "foo has been deprecated");
}

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const build_opt_return = code_reminder_build.addCodeRemindersToBuildOptions(b, null);
    const build_code_reminders = CodeReminders.init(build_opt_return.options);

    buildUtilFunctionToBeReplaced(b, &build_code_reminders);
    foo(b, &build_code_reminders);

    const exe = b.addExecutable(.{
        .name = "main",
        .target = target,
        .optimize = optimize,
        .root_source_file = .{ .path = "main.zig" },
    });

    b.installArtifact(exe);
}
