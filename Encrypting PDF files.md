# Encrypting PDF files in Kali Linux

### Install QPDF

      sudo apt-get install qpdf

### Encrypting PDF File Command

      qpdf --encrypt Enter_your_Password Enter_your_Password 256 -- Enter_Your_File_Name.pdf Enter_Your_Encrypt_File_Name.pdf

### Example

      qpdf --encrypt mypassword mypassword 256 -- input_file.pdf output_file.pdf
      
