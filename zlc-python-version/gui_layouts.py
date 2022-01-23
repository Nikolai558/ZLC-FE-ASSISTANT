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
    sg.Frame('',
             [[sg.Button('A)', font=msg.FONT_REGULAR, size=(5, 2), pad=((2, 10), (10, 10))), sg.Text('Split a current vERAM ZLC GeoMaps.xml or vSTARS Video Maps.xml into multiple individual files.', font=msg.FONT_REGULAR)],
              [sg.Button('B)', font=msg.FONT_REGULAR, size=(5, 2), pad=((2, 10), (10, 10))), sg.Text('Take the export data from the FE-BUDDY parser and transfer to coorisponding EDIT files.', font=msg.FONT_REGULAR)],
              [sg.Button('C)', font=msg.FONT_REGULAR, size=(5, 2), pad=((2, 10), (10, 10))), sg.Text('Change the vERAM data Release Date and the .VERSION command.', font=msg.FONT_REGULAR)],
              [sg.Button('D)', font=msg.FONT_REGULAR, size=(5, 2), pad=((2, 10), (10, 10))), sg.Text('Combine split GeoMaps or Video Maps into a single ZLC GeoMaps.xml or ___ Video Maps.xml file.\n\t- Ensure only the files that you want to combine are in the directory you select.', font=msg.FONT_REGULAR)],
              [sg.Button('E)', font=msg.FONT_REGULAR, size=(5, 2), pad=((2, 10), (10, 10))), sg.Text('Combine and Transfer all EDIT SCT files to the Pre-Release ZLC SECTOR.sct2 file.', font=msg.FONT_REGULAR)],
              [sg.Button('F)', font=msg.FONT_REGULAR, size=(5, 2), pad=((2, 10), (10, 10))), sg.Text('Combine and Transfer all EDIT ALIAS files to the Pre-Release ZLC ALIAS.txt file.\n\t---REMINDER: Launch vSTARS/vERAM, load new Alias/POF/GEOMAPs as needed \n\tand export the .gz to Pre-Release folder.', font=msg.FONT_REGULAR)],
              [sg.Button('G)', font=msg.FONT_REGULAR, size=(5, 2), pad=((2, 10), (10, 10))), sg.Text('Transfer Pre-Release Files to ZLC Public Folder.', font=msg.FONT_REGULAR)]
              ],
             key='-MAIN-FRAME-', expand_x=True, expand_y=True, border_width=0, visible=False)
]
