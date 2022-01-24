import PySimpleGUI as sg
import gui_layouts as layouts

# Static Window Variables.
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

    def update_check(self):
        # TODO - Create and Implement Update_Check
        pass

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

            # TEMP - Button to exit out of the Progress Screen
            if event == '-PRG-CONTINUE-':
                self.window['-PRG-FRAME-'].update(visible=False)
                self.window['-MAIN-FRAME-'].update(visible=True)

            # User has chosen option 'A'
            if event == 'A)':
                self.window['-MAIN-FRAME-'].update(visible=False)
                self.window['-PRG-FRAME-'].update(visible=True)
                # TODO - Create and Implement Split GeoMaps or VideoMaps Function

            # User has chosen option 'B'
            if event == 'B)':
                self.window['-MAIN-FRAME-'].update(visible=False)
                self.window['-PRG-FRAME-'].update(visible=True)
                # TODO - Create and Implement FE Buddy Export and Transfer Function

            # User has chosen option 'C'
            if event == 'C)':
                self.window['-MAIN-FRAME-'].update(visible=False)
                self.window['-PRG-FRAME-'].update(visible=True)
                # TODO - Create and Implement Change Data Release Date in Alias and vERAM Function

            # User has chosen option 'D'
            if event == 'D)':
                self.window['-MAIN-FRAME-'].update(visible=False)
                self.window['-PRG-FRAME-'].update(visible=True)
                # TODO - Create and Implement Combine GeoMaps or VideoMaps into single xml Function.

            # User has chosen option 'E'
            if event == 'E)':
                self.window['-MAIN-FRAME-'].update(visible=False)
                self.window['-PRG-FRAME-'].update(visible=True)
                # TODO - Create and Implement Combine and Transfer SCT Files Function

            # User has chosen option 'F'
            if event == 'F)':
                self.window['-MAIN-FRAME-'].update(visible=False)
                self.window['-PRG-FRAME-'].update(visible=True)
                # TODO - Create and Implement Combine and Transfer Alias files Function

            # User has chosen option 'G'
            if event == 'G)':
                self.window['-MAIN-FRAME-'].update(visible=False)
                self.window['-PRG-FRAME-'].update(visible=True)
                # TODO - Create and Implement Transfer to Public Function

        self.window.close()


if __name__ == '__main__':
    program = AssistantWindow()
    program.event_loop()
