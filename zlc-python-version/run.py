import PySimpleGUI as sg
import requests as requests

import gui_frames as frames

PROGRAM_VERSION = '1.0.0'

# Static Window Variables.
WINDOW_SIZE = (800, 500)

# Create the layout for the window
# Layouts must be ordered from most bottom to top otherwise window spacing issues happen.
LAYOUT = [[
    sg.Column([frames.not_implemented_frame], key='-NOT_IMPLEMENTED-FRAME-', expand_x=True, expand_y=True, visible=False),
    sg.Column([frames.progress_frame], key='-PROG-FRAME-', expand_x=True, expand_y=True, visible=False),
    sg.Column([frames.split_maps_frame], key='-SPLIT-MAPS-FRAME-', expand_x=True, expand_y=True, visible=False),
    sg.Column([frames.main_frame], key='-MAIN-FRAME-', expand_x=True, expand_y=True, visible=False),
    sg.Column([frames.msg_frame], key='-MSG-FRAME-', expand_x=True, expand_y=True, visible=True)
]]


class AssistantWindow:
    def __init__(self):
        self.window = sg.Window('ZLC FE Assistant', LAYOUT, size=WINDOW_SIZE)
        self.update_check()
        # self.event_loop()

    def update_check(self):
        # TODO - Create and Implement Update_Check
        github_base_url = 'https://raw.githubusercontent.com/KSanders7070/ZLC-FE-ASSISTANT/'
        version_url = github_base_url + 'main/Version_Check'
        r = requests.get(version_url)
        if r.status_code == 200:
            if r.text.split('-')[1] != PROGRAM_VERSION:
                print('Program needs updated...')
        else:
            print('Request to Github provided a status code of {0} -'.format(r.status_code), r.reason)

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
            if event == '-NOT_IMPLEMENTED-CONTINUE-' or event == '-PROG-CONTINUE-':
                self.window['-NOT_IMPLEMENTED-FRAME-'].update(visible=False)
                self.window['-PROG-FRAME-'].update(visible=False)
                self.window['-MAIN-FRAME-'].update(visible=True)

            # User has chosen option 'A'
            if event == 'A)':
                self.window['-MAIN-FRAME-'].update(visible=False)
                self.window['-SPLIT-MAPS-FRAME-'].update(visible=True)

            # User has chosen option 'B'
            if event == 'B)':
                self.window['-MAIN-FRAME-'].update(visible=False)
                self.window['-NOT_IMPLEMENTED-FRAME-'].update(visible=True)
                # TODO - Create and Implement FE Buddy Export and Transfer Function

            # User has chosen option 'C'
            if event == 'C)':
                self.window['-MAIN-FRAME-'].update(visible=False)
                self.window['-NOT_IMPLEMENTED-FRAME-'].update(visible=True)
                # TODO - Create and Implement Change Data Release Date in Alias and vERAM Function

            # User has chosen option 'D'
            if event == 'D)':
                self.window['-MAIN-FRAME-'].update(visible=False)
                self.window['-NOT_IMPLEMENTED-FRAME-'].update(visible=True)
                # TODO - Create and Implement Combine GeoMaps or VideoMaps into single xml Function.

            # User has chosen option 'E'
            if event == 'E)':
                self.window['-MAIN-FRAME-'].update(visible=False)
                self.window['-NOT_IMPLEMENTED-FRAME-'].update(visible=True)
                # TODO - Create and Implement Combine and Transfer SCT Files Function

            # User has chosen option 'F'
            if event == 'F)':
                self.window['-MAIN-FRAME-'].update(visible=False)
                self.window['-NOT_IMPLEMENTED-FRAME-'].update(visible=True)
                # TODO - Create and Implement Combine and Transfer Alias files Function

            # User has chosen option 'G'
            if event == 'G)':
                self.window['-MAIN-FRAME-'].update(visible=False)
                self.window['-NOT_IMPLEMENTED-FRAME-'].update(visible=True)
                # TODO - Create and Implement Transfer to Public Function

            if event == '-SPLIT-vSTARS-':
                self.window['-SPLIT-MAPS-FRAME-'].update(visible=False)
                self.window['-PROG-HEADER-'].update('SPLITTING vSTARS VideoMaps')
                self.window['-PROG-DESCRIPTION-'].update('stuff..')
                self.window['-PROG-FRAME-'].update(visible=True)
                # TODO - Create and Implement split vstars video maps

        self.window.close()

    def split_maps(self):
        pass


if __name__ == '__main__':
    program = AssistantWindow()
    program.event_loop()
