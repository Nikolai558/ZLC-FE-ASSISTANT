# ZLC-FE-ASSISTANT
For use by the vZLC ARTCC Facility Engineer to assist in the management of facility files.

This BATCH File will do the following:

A)  Split a current ZLC GeoMaps.xml into multiple individual files for each GeoMap.

B)  Take the export data from the FE-BUDDY parser and transfer to corresponding EDIT files.

C)  Change the vERAM data Release Date and the .VERSION command.

D)  Combine split GeoMap files into a single ZLC GeoMaps.xml.
  - Ensure only the files that you want to combine are in the directory you select.

E)  Combine and Transfer all SCT2 EDIT files to the Pre-Release ZLC SECTOR.sct2 file.

F)  Combine and Transfer all EDIT ALIAS files to the Pre-Release ZLC ALIAS.txt file.
  - REMINDER: Launch vSTARS/vERAM, load new Alias/POF/GEOMAP's as needed and export the .gz to Pre-Release folder.

G) Transfer Pre-Release Files to ZLC Public Folder.
