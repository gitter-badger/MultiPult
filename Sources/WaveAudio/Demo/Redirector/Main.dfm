�
 TMAINFORM 0>  TPF0	TMainFormMainFormLeft� Top� BorderStylebsDialogCaptionSound RedirectorClientHeight� ClientWidth*Color	clBtnFaceFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style OldCreateOrder	OnCreate
FormCreatePixelsPerInch`
TextHeight TLabelLabel1LeftTopfWidthHeightAutoSizeCaptionTThis sample program records audio from Microphone and plays it back on the speakers.WordWrap	  TLabelFormatLabelLeftTopWidthAHeightCaptionAudio Format:FocusControlFormat  TLabelLabel2LeftTop� WidthHeightAutoSizeCaption4Optionally you can save recorded audio in to a file.WordWrap	  TLabelFileNameLabelLeftTop� WidthUHeightCaptionOutput File Name:  	TCheckBoxckActiveLeftTopPWidthAHeightCaptionActiveTabOrderOnClickckActiveClick  TProgressBar
AudioLevelLeftTop8WidthHeightTabOrder  	TComboBoxFormatLeftTopWidthHeightStylecsDropDownList
ItemHeightTabOrder OnChangeFormatChange  	TCheckBoxckSaveLeftTop� WidthaHeightCaption
Save AudioTabOrderOnClickckSaveClick  TEditFileNameLeftTop� Width� HeightTabOrder  TButton	btnBrowseLeftTop� WidthHeightCaption...TabOrderOnClickbtnBrowseClick  TAudioRedirector
RedirectorBufferCount
OnActivateRedirectorActivateOnDeactivateRedirectorDeactivateLeft Top  TSaveDialog
SaveDialog
DefaultExtwavFileNameSampleFilter,Wave Files (*.wav)|*.wav|All Files (*.*)|*.*TitleRecord Sound ToLeft� Top   