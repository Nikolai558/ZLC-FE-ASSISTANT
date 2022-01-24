FONT_LARGE = 'Arial, 16'
FONT_REGULAR = 'Arial, 12'
FONT_SMALL = 'Arial, 8'

ADVISORY_HEADER = """
**********
 ADVISORY
**********
"""

ADVISORY = """
Many of the functions within this BATCH file assume that
the user has access to the ZLC FACILITY DROPBOX
directories and that Dropbox is installed on the 'C:' drive
like so:

C:\\Users\\JohnSmith\\Dropbox\\ZLC 6. Internal Facility Files
"""

PROGRAM_OPTIONS = [
    'Split a current vERAM ZLC GeoMaps.xml or vSTARS Video Maps.xml into multiple individual files.',
    'Take the export data from the FE-BUDDY parser and transfer to corresponding EDIT files.',
    'Change the vERAM data Release Date and the .VERSION command.',
    'Combine split GeoMaps or Video Maps into a single ZLC GeoMaps.xml or ___ Video Maps.xml file.\n\t- Ensure only the'
    ' files that you want to combine are in the directory you select.',
    'Combine and Transfer all EDIT SCT files to the Pre-Release ZLC SECTOR.sct2 file.',
    'Combine and Transfer all EDIT ALIAS files to the Pre-Release ZLC ALIAS.txt file.\n\t---REMINDER: Launch'
    ' vSTARS/vERAM, load new Alias/POF/GEOMAPs as needed \n\tand export the .gz to Pre-Release folder.',
    'Transfer Pre-Release Files to ZLC Public Folder.'
]
