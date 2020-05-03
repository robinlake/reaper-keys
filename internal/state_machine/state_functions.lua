local state_interface = require('state_machine.state_interface')
local constants = require("state_machine.constants")
local utils = require("command.utils")

local state_functions = {}

function state_functions.checkIfConsistentState(state)
  local current_state = state_interface.get()
  for k,value in pairs(current_state) do
    if k == 'last_command' then
      if not utils.checkIfCommandsAreEqual(state.last_command, current_state.last_command) then
        return false
      end
    elseif value ~= state[k] then
        return false
    end
  end
  return true
end

function state_functions.setTimelineSelectionSide(left_or_right)
  local state = state_interface.get()
  state['timeline_selection_side'] = left_or_right
  state_interface.set(state)
end

function state_functions.getTimelineSelectionSide()
  local state = state_interface.get()
  return state['timeline_selection_side']
end

function state_functions.toggleMode(mode)
  local state = state_interface.get()
  if state.mode == mode then
    state.mode = 'normal'
  else
    state.mode = mode
  end
  state_interface.set(state)
end

function state_functions.resetToNormal()
  state_interface.set(constants['reset_state'])
end

return state_functions