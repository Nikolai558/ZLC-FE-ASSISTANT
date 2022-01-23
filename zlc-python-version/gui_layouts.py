# TODO - Only import what is needed.
import PySimpleGUI as sg
import messages as msg

THEME = 'DARK'

# The theme has to be set with all the layout components/elements otherwise only the BG will be set.
sg.theme(THEME)  # Add a touch of color

msg_frame = [
    sg.Frame('',
             [[sg.Text(msg.ADVISORY_HEADER, justification='center', expand_x=True, font=msg.FONT_LARGE)],
              [sg.Text(msg.ADVISORY, font=msg.FONT_REGULAR, expand_x=True, pad=((60, 60), (0, 50)))],
              [sg.Column([[sg.Button('Continue', size=(20, 0), font=msg.FONT_REGULAR)]], justification='center')]
              ],
             key='-MSG-FRAME-', expand_x=True, expand_y=True, border_width=0, visible=True)
]
