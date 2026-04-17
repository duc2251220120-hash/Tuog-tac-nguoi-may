import os
import re

files_to_update = [
    r'd:\Tuong_tac_nguoi_may\career_global\lib\features\profile\presentation\screens\my_profile_screen.dart',
    r'd:\Tuong_tac_nguoi_may\career_global\lib\features\profile\presentation\screens\complete_profile_screen.dart',
    r'd:\Tuong_tac_nguoi_may\career_global\lib\features\mentor\presentation\screens\find_mentor_screen.dart',
    r'd:\Tuong_tac_nguoi_may\career_global\lib\features\jobs\presentation\screens\job_detail_screen.dart',
    r'd:\Tuong_tac_nguoi_may\career_global\lib\features\jobs\presentation\screens\job_search_screen.dart',
    r'd:\Tuong_tac_nguoi_may\career_global\lib\features\home\presentation\screens\home_screen.dart',
    r'd:\Tuong_tac_nguoi_may\career_global\lib\features\auth\presentation\screens\login_screen.dart',
    r'd:\Tuong_tac_nguoi_may\career_global\lib\features\auth\presentation\screens\forgot_password_screen.dart',
    r'd:\Tuong_tac_nguoi_may\career_global\lib\features\connections\presentation\screens\explore_screen.dart',
    r'd:\Tuong_tac_nguoi_may\career_global\lib\features\jobs\presentation\screens\apply_job_screen.dart'
]

# Exclusions where we STILL want context.go()
# Splitting by spaces or specific patterns is tricky, let's just do a pattern replace and skip exceptions.
exceptions = [
    "AppRoutePaths.login",
    "AppRoutePaths.home",
    "AppRoutePaths.onboarding",
    "AppRoutePaths.otp",
    "AppRoutePaths.completeProfile"
]

for filepath in files_to_update:
    if not os.path.exists(filepath):
        continue
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    # Find all context.go()
    def replacer(match):
        full_match = match.group(0)
        route_arg = match.group(1)
        if any(ex in route_arg for ex in exceptions):
            return full_match # don't replace
        return f"context.push({route_arg})"

    new_content = re.sub(r'context\.go\(([^)]+)\)', replacer, content)

    if new_content != content:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(new_content)
        print(f"Updated {filepath}")
