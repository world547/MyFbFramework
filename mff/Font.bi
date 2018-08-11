﻿'###############################################################################
'#  Font.bi                                                                  #
'#  This file is part of MyFBFramework                                           #
'#  Version 1.0.0                                                              #
'###############################################################################

#Include Once "Object.bi"

Namespace My.Sys.Drawing
    #DEFINE QFont(__Ptr__) *Cast(Font Ptr,__Ptr__)

    Type Font Extends My.Sys.Object
        Private:
            FTemp      As WString Ptr
            FName      As String
            FBold      As Boolean
            FItalic    As Boolean
            FUnderline As Boolean
            FStrikeOut As Boolean
            FSize      As Integer
            FColor     As Integer
            FCharSet   As Integer 
            FParent    As HWND
            FBolds(2)  As Integer
            FCyPixels  As Integer
            Declare Sub Create
        Public:
            Handle As HFONT
            Declare Function ToString ByRef As WString
            Declare Property Parent As HWND
            Declare Property Parent(Value As HWND)
            Declare Property Name As String
            Declare Property Name(Value As String)
            Declare Property Color As Integer
            Declare Property Color(Value As Integer)
            Declare Property Size As Integer
            Declare Property Size(Value As Integer)
            Declare Property CharSet As Integer
            Declare Property CharSet(Value As Integer)
            Declare Property Bold As Boolean
            Declare Property Bold(Value As Boolean)
            Declare Property Italic As Boolean
            Declare Property Italic(Value As Boolean)
            Declare Property Underline As Boolean
            Declare Property Underline(Value As Boolean)
            Declare Property StrikeOut As Boolean
            Declare Property StrikeOut(Value As Boolean)
            Declare Operator Cast As Any Ptr
            Declare Operator Cast ByRef As WString
            Declare Operator Let(Value As Font) 
            Declare Constructor
            Declare Destructor
    End Type

    Sub Font.Create
        If Handle Then DeleteObject(Handle) 
        Handle = CreateFontW(-MulDiv(FSize,FcyPixels,72),0,0,0,FBolds(Abs_(FBold)),FItalic,FUnderline,FStrikeout,FCharSet,OUT_TT_PRECIS,CLIP_DEFAULT_PRECIS,DEFAULT_QUALITY,FF_DONTCARE,FName)
        If Handle Then
            If FParent Then
                SendMessage(FParent ,WM_SETFONT,CUInt(Handle),True)
                InvalidateRect FParent,0,True
            End If
        End If
    End Sub

    Property Font.Parent As HWND
        Return FParent
    End Property

    Property Font.Parent(Value As HWND)
        FParent = value
        Create
    End Property

    Property Font.Name As String
        Return FName 
    End Property

    Property Font.Name(Value As String)
        FName = value
        Create
    End Property

    Property Font.Color As Integer
        Return FColor
    End Property

    Property Font.Color(Value As Integer)
        FColor = value
        Create
    End Property

    Property Font.CharSet As Integer
        Return FCharSet
    End Property

    Property Font.CharSet(Value As Integer)
         FCharSet = value
         Create
    End Property

    Property Font.Size As Integer
         Return FSize
    End Property

    Property Font.Size(Value As Integer)
        FSize = value
        Create
    End Property

    Property Font.Bold As Boolean
        Return FBold
    End Property

    Property Font.Bold(Value As Boolean)
        FBold = value
        Create
    End Property

    Property Font.Italic As Boolean
         Return FItalic
    End Property

    Property Font.Italic(Value As Boolean)
        FItalic = value
        Create
    End Property

    Property Font.Underline As Boolean
        Return FUnderline
    End Property

    Property Font.Underline(Value As Boolean)
        FUnderline = value
        Create
    End Property

    Property Font.StrikeOut As Boolean
       Return FStrikeout
    End Property

    Property Font.StrikeOut(Value As Boolean)
       FStrikeout = value
       Create
    End Property

    Operator Font.Cast As Any Ptr
        Return @This
    End Operator

    Operator Font.Cast ByRef As WString
        Return ToString
    End Operator

    Function Font.ToString ByRef As WString
        WLet FTemp, This.Name & ", " & This.Size
        Return *FTemp
    End Function
    
    Operator Font.Let(Value As Font)
        With Value
            FName      = .Name
            FBold      = .Bold
            FItalic    = .Italic
            FUnderline = .Underline
            FStrikeOut = .StrikeOut
            FSize      = .Size
            FColor     = .Color
            FCharSet   = .CharSet
        End With
        Create
    End Operator

    Constructor Font
        Dim As HDC Dc
        Dc = GetDC(HWND_DESKTOP)
        FCyPixels = GetDeviceCaps(DC, LOGPIXELSY)
        ReleaseDC(HWND_DESKTOP,DC)
        FBolds(0) = 400
        FBolds(1) = 700
        FName     = "TAHOMA"
        FSize     = 8
        FCharSet  = DEFAULT_CHARSET
        Create
    End Constructor

    Destructor Font
        If Handle Then DeleteObject(Handle)
    End Destructor
End namespace
