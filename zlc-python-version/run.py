import PySimpleGUI as sg
import gui_layouts as layouts

# Static Window Variables.
# TODO - Window_Size is not used right now.
WINDOW_SIZE = (800, 500)

# Create the layout for the window
# Layouts must be ordered from most bottom to top otherwise window spacing issues happen.
LAYOUT = [[
    sg.Column([layouts.progress_frame], key='-PRG-FRAME-', expand_x=True, expand_y=True, visible=False),
    sg.Column([layouts.main_frame], key='-MAIN-FRAME-', expand_x=True, expand_y=True, visible=False),
    sg.Column([layouts.msg_frame], key='-MSG-FRAME-', expand_x=True, expand_y=True, visible=True)
]]


class AssistantWindow:
    def __init__(self):
        self.window = sg.Window('ZLC FE Assistant', LAYOUT, size=WINDOW_SIZE)

    def event_loop(self):
        """In charge of keeping GUI open and checking user actions."""
        while True:
            # events = user actions; values = user input
            event, values = self.window.read()

            # user clicked 'X' to close the window.
            if event == sg.WIN_CLOSED:
                break

            # user clicked 'Continue Button' in the msg_frame
            if event == '-MSG-CONTINUE-':
                self.window['-MSG-FRAME-'].update(visible=False)
                self.window['-MAIN-FRAME-'].update(visible=True)

            if event == '-PRG-CONTINUE-':
                self.window['-PRG-FRAME-'].update(visible=False)
                self.window['-MAIN-FRAME-'].update(visible=True)

            if event == 'A)':
                self.window['-MAIN-FRAME-'].update(visible=False)
                self.window['-PRG-FRAME-'].update(visible=True)

        self.window.close()


if __name__ == '__main__':
    program = AssistantWindow()
    program.event_loop()
