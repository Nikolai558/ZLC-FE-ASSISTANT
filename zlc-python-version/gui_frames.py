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
                       justification='center',
                       font=msg.FONT_REGULAR,
                       expand_x=True,
                       pad=((60, 60), (0, 50)))],
              [sg.Column([[sg.Button('Continue', size=(20, 0),
                                     font=msg.FONT_REGULAR,
                                     key='-MSG-CONTINUE-')]],
                         justification='center')]
              ],
             expand_x=True, expand_y=True, border_width=0, visible=True)
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
             expand_x=True, expand_y=True, border_width=0, visible=True)
]

split_maps_frame = [
    sg.Frame('',
             [[sg.Text(msg.SPLIT_MAPS_HEADER,
                       justification='center',
                       expand_x=True,
                       font=msg.FONT_LARGE)],
              [sg.Text(msg.SPLIT_MAPS,
                       justification='center',
                       font=msg.FONT_REGULAR,
                       expand_x=True,
                       pad=((60, 60), (0, 50)))],
              [sg.Column([[sg.Button('vSTARS', size=(20, 0),
                                     font=msg.FONT_REGULAR,
                                     key='-SPLIT-vSTARS-'),
                           sg.Button('vERAM', size=(20, 0),
                                     font=msg.FONT_REGULAR,
                                     key='-SPLIT-vERAM-')],
                          ],
                         justification='center')]
              ],
             expand_x=True, expand_y=True, border_width=0, visible=True)
]

progress_frame = [
    sg.Frame('',
             [[sg.Text("{HEADER}",
                       justification='center',
                       expand_x=True,
                       font=msg.FONT_LARGE,
                       key='-PROG-HEADER-')],
              [sg.Text("\n{Description}",
                       justification='center',
                       font=msg.FONT_REGULAR,
                       expand_x=True,
                       pad=((60, 60), (0, 50)),
                       key='-PROG-DESCRIPTION-')],
              [sg.Column([[
                  # TEMP - Button to exit out of the Progress Screen
                  sg.Button('Continue', size=(20, 0),
                            font=msg.FONT_REGULAR,
                            key='-PROG-CONTINUE-')]],
                         justification='center')]
              ],
             expand_x=True, expand_y=True, border_width=0, visible=True)
]

not_implemented_frame = [
    sg.Frame('',
             [[sg.Text("THIS FUNCTION HAS NOT BEEN IMPLEMENTED",
                       justification='center',
                       expand_x=True,
                       font=msg.FONT_LARGE)],
              [sg.Text("To help with development or get status updates please checkout: \n"
                       "https://github.com/Nikolai558/ZLC-FE-ASSISTANT\n",
                       justification='center',
                       font=msg.FONT_REGULAR,
                       expand_x=True,
                       pad=((60, 60), (0, 50)))],
              [sg.Column([[
                  # TEMP - Button to exit out of the NOT_IMPLEMENTED Screen
                  sg.Button('Continue', size=(20, 0),
                            font=msg.FONT_REGULAR,
                            key='-NOT_IMPLEMENTED-CONTINUE-')]],
                         justification='center')]
              ],
             expand_x=True, expand_y=True, border_width=0, visible=True)
]
