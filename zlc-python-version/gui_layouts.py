# TODO - Only import what is needed.
import PySimpleGUI as sg
import messages as msg

THEME = 'DARK'

# The theme has to be set with all the layout components/elements otherwise only the BG will be set.
sg.theme(THEME)  # Add a touch of color

msg_frame = [
    sg.Frame('',
             [[sg.Text(msg.ADVISORY_HEADER,
                       justification='center',
                       expand_x=True,
                       font=msg.FONT_LARGE)],
              [sg.Text(msg.ADVISORY,
                       font=msg.FONT_REGULAR,
                       expand_x=True,
                       pad=((60, 60), (0, 50)))],
              [sg.Column([[sg.Button('Continue', size=(20, 0),
                                     font=msg.FONT_REGULAR,
                                     key='-MSG-CONTINUE-')]],
                         justification='center')]
              ],
             key='-MSG-FRAME-', expand_x=True, expand_y=True, border_width=0, visible=True)
]

main_frame = [
    sg.Frame('', [
                [
                    sg.Button('A)', font=msg.FONT_REGULAR, size=(5, 2), pad=((2, 10), (10, 10))),
                    sg.Text(msg.PROGRAM_OPTIONS[0], font=msg.FONT_REGULAR)
                ],
                [
                    sg.Button('B)', font=msg.FONT_REGULAR, size=(5, 2), pad=((2, 10), (10, 10))),
                    sg.Text(msg.PROGRAM_OPTIONS[1], font=msg.FONT_REGULAR)
                ],
                [
                    sg.Button('C)', font=msg.FONT_REGULAR, size=(5, 2), pad=((2, 10), (10, 10))),
                    sg.Text(msg.PROGRAM_OPTIONS[2], font=msg.FONT_REGULAR)
                ],
                [
                    sg.Button('D)', font=msg.FONT_REGULAR, size=(5, 2), pad=((2, 10), (10, 10))),
                    sg.Text(msg.PROGRAM_OPTIONS[3], font=msg.FONT_REGULAR)
                ],
                [
                    sg.Button('E)', font=msg.FONT_REGULAR, size=(5, 2), pad=((2, 10), (10, 10))),
                    sg.Text(msg.PROGRAM_OPTIONS[4], font=msg.FONT_REGULAR)
                ],
                [
                    sg.Button('F)', font=msg.FONT_REGULAR, size=(5, 2), pad=((2, 10), (10, 10))),
                    sg.Text(msg.PROGRAM_OPTIONS[5], font=msg.FONT_REGULAR)
                ],
                [
                    sg.Button('G)', font=msg.FONT_REGULAR, size=(5, 2), pad=((2, 10), (10, 10))),
                    sg.Text(msg.PROGRAM_OPTIONS[6], font=msg.FONT_REGULAR)
                ]],
             key='-MAIN-FRAME-', expand_x=True, expand_y=True, border_width=0, visible=False)
]
