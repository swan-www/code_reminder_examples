const std = @import("std");
const module_code_reminder = @import("module_code_reminder");
const code_reminder = module_code_reminder.code_reminder;
const code_reminder_options = @import("code_reminder_options");

const CodeReminderAsError = error{ Foo, Bar };

const CodeReminders = struct {
    const Foo = code_reminder.CodeReminder.comptimeInit(code_reminder_options, 12345, CodeReminderAsError.Foo);
    const Bar = code_reminder.CodeReminder.comptimeInit(code_reminder_options, null, CodeReminderAsError.Bar);
};

fn fooFunc() void {
    comptime {
        CodeReminders.Foo.comptimeCheck(@src(), "fooFunc has been deprecated");
    }
}

pub fn main() !void {
    std.debug.print("Hello, World!\n", .{});

    fooFunc();
}
