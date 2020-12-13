# gearswap-data
FFXI GearSwap scripts

## SilverLibs
The SilverLibs.lua file contains functionality that is designed to be easily implemented into job files. To use any of these functions, follow the instructions below:

**Installing Silverlibs**
1. The SilverLibs.lua file should be placed in the gearswap/data folder or in the gearswap/libs folder.
2. Add the following line at the top of your gearswap file in which you wish to use the function. If you have a global file, you can put it at the top of that one instead.
```
include('SilverLibs')
```
3. Mote library is required for this to work. To enable Mote libs, add this to the top of your `get_sets` function:
```
mote_include_version = 2
include('Mote-Include.lua')
```

### Cancel WS use if out of range
**Description**

Cancels the WS command from being sent to the game if you are out of range. Normally, executing a WS when out of range results in losing your TP without actually performing the WS. This is a blocker that will prevent the action from going through and prevent gear swapping.

**Implementation**

In your job file, add the following code to the beginning of your `job_precasts` function:
```
cancel_outranged_ws(spell, eventArgs)
```

If you do not have a `job_precasts` function in your lua, you can just add that as follows:
```
function job_precast(spell, action, spellMap, eventArgs)
  cancel_outranged_ws(spell, eventArgs)
end
```

### Cancel action if blocked by status effect
**Description**

When you use a spell, item, ability, etc this will check to see if you have a status effect that blocks this action (for example, Silence status will block magic casting). If you have a blocking status effect, this function will cancel your attempted action and prevent gear swapping.

**Implementation**

In your job file, add the following code to the beginning of your `job_precasts` function:
```
cancel_on_blocking_status(spell, eventArgs)
```

If you do not have a `job_precasts` function in your lua, you can just add that as follows:
```
function job_precast(spell, action, spellMap, eventArgs)
  cancel_on_blocking_status(spell, eventArgs)
end
```

### Automatic weapon re-arming
**Descripton**

Whenever your weapons are removed, this function will re-equip whatever you previously had equipped. This covers 'main', 'sub', 'ranged', and 'ammo' slots.

Functionality can be temporarily disabled by adding a togglable weapon lock state:
```
state.WeaponLock = M(false, 'Weapon Lock')
```

And add a keybind to perform the actual toggling (WIN+W is used here but it can be anything you want):
```
send_command('bind @w gs c toggle WeaponLock')
```

**Implementation**

In your job file after `include`ing SilverLibs and Mote libs, add the following:
```
USE_WEAPON_REARM = true
```
Recommend putting it in your job lua instead of globals.

**Known Issue**

The 'sub' slot sometimes does not re-equip properly. Possibly a race condition.

### Dynamic global weaponskill keybinds
**Descripton**

Provides weaponskill keybinds that change dynamically based on your current weapon. The main purpose is
so you can easily use multiple weapons on one job while using common keybinds for your skills (for example,
you can always have Evisceration on the same button regardless of job).

Override functionality is included so that you can define your own keybinds in a global file without having
to modify this library lua. Think of the keybinds defined in this library as defaults and you can override
for a specific weapon's keybinds. To do so, create a global keybind file called `CharacterName-Globals.lua` and
add a table called `user_ws_bindings`. This table must have the same format as `default_ws_bindings` in the library lua.
The syntax is as follows:
```
user_ws_bindings = {
  ['Weapon Category'] = {
    ['Default'] = {
      ['keybind1'] = "WS Name",
      ['keybind2'] = "WS2 Name",
    },
    ['JOB'] = {
      ['keybind1'] = "WS3 Name",
    },
    ['/SUB'] = {
      ['keybind1'] = "WS4 Name",
    },
  },
}
```
The category's bindings will be merged in the following order: Default -> Job (using player's current job) -> Sub (using
player's current sub job). Default bindings will apply regardless of job. Job-specific bindings will overwrite Default
bindings in the case that they both define the same keybind. Sub-job-specific bindings will overwrite the other two.

Note 1: To use a subjob binding the job must be prefixed with '/'. For example, '/NIN' will apply
those bindings if your sub job is Ninja.

Note 2: The 'Default' key is case-sensitive, you must use a capital 'D'. The job and sub job keys are not case sensitive.

**Implementation**

In your job file after `include`ing SilverLibs and Mote libs, add the following:
```
USE_DYNAMIC_MAIN_WS_KEYBINDS = true
```
Recommend putting it in your job lua instead of globals.

If you want to use `<stnpc>` targeting instead of `<t>` for your weaponskills you can set the following line
of code in the same place:
```
MAIN_WS_TARGET_MODE = 'stnpc'
```