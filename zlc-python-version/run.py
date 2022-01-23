import PySimpleGUI as sg
import gui_layouts as layouts

# Static Window Variables.
# TODO - Window_Size is not used right now.
WINDOW_SIZE = (1000, 650)

# Create the layout for the window
LAYOUT = [layouts.msg_frame]


class AssistantWindow:
    def __init__(self):
        self.window = sg.Window('ZLC FE Assistant', LAYOUT)

    def event_loop(self):
        """In charge of keeping GUI open and checking user actions."""
        while True:
            # events = user actions; values = user input
            event, values = self.window.read()

            # user clicked 'X' to close the window.
            if event == sg.WIN_CLOSED:
                break

            # user clicked 'Continue Button' in the msg_frame
            if event == 'Continue':
                self.window['-MSG-FRAME-'].update(visible=False)

        self.window.close()


if __name__ == '__main__':
    program = AssistantWindow()
    program.event_loop()
