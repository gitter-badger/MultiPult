�
 TMAINFORM 0�  TPF0	TMainFormMainFormLeft� Top� ActiveControlbtnStartBorderIconsbiSystemMenu
biMinimize BorderStylebsSingleCaptionBroadcaster (Server)ClientHeight�ClientWidth2Color	clBtnFaceFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style OldCreateOrderOnCloseQueryFormCloseQueryOnCreate
FormCreate
DesignSize2� PixelsPerInch`
TextHeight 	TGroupBoxgbBroadcastingLeftTopGWidth#HeightvAnchorsakLeftakRightakBottom Caption Broadcasting (Microphone) TabOrder
DesignSize#v  TLabel	lblFormatLeftTopWidthAHeightCaptionAudio Format:FocusControlcbFormat  	TComboBoxcbFormatLeftTop(WidthHeightStylecsDropDownListAnchorsakLeftakTopakRight 
ItemHeightTabOrder   TProgressBarpbLevelLeftzTopPWidth� HeightAnchorsakLeftakTopakRight BorderWidthTabOrder  TButtonbtnStopLeftTopLWidthaHeightCaptionStopTabOrderVisibleOnClickbtnStopClick  TButtonbtnStartLeftTopLWidthaHeightCaptionStartTabOrderOnClickbtnStartClick   	TGroupBoxgbConnectionLeftTopWidth#Height8AnchorsakLeftakTopakRightakBottom Caption Connection TabOrder 
DesignSize#8  TLabel
lblClientsLeftTopHWidth"HeightCaptionClients:FocusControl
lstClients  TLabellblLocalAddressLeftTopWidth)HeightCaptionAddress:FocusControledLocalAddress  TLabellblLocalPortLeft� TopWidthHeightAnchorsakTopakRight CaptionPort:FocusControlseLocalPort  TListBox
lstClientsLeftTopXWidthHeight� AnchorsakLeftakTopakRightakBottom 
ItemHeightTabOrder  TEditedLocalAddressLeftTop(Width� HeightTabStopAnchorsakLeftakTopakRight ParentColor	ReadOnly	TabOrder   	TSpinEditseLocalPortLeft� Top(WidthIHeightHint7Be sure the specified port is not closed by a firewall.AnchorsakTopakRight MaxValue?B MinValueParentShowHintShowHint	TabOrderValue�   TLiveAudioRecorderLiveAudioRecorder	PCMFormatStereo16bit48000HzBufferLengthdBufferCount

OnActivateLiveAudioRecorderActivateOnDeactivateLiveAudioRecorderDeactivateOnLevelLiveAudioRecorderLevelOnDataLiveAudioRecorderDataLeft� Top�    