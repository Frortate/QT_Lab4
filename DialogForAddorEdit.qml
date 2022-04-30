import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 2.5   // это версия библиотеки, содержащей Contol (аналоги виджетов) для версии Qt 5.6
import QtQuick.Layouts 1.2


Window {
    id: root
    modality: Qt.ApplicationModal  // окно объявляется модальным
    title: qsTr("Добавление/Редактирование информации")
    minimumWidth: 400
    maximumWidth: 400
    minimumHeight: 200
    maximumHeight: 200

    property bool isEdit: false
    property int currentIndex: -1

    GridLayout {
        anchors { left: parent.left; top: parent.top; right: parent.right; bottom: buttonCancel.top; margins: 10 }
        columns: 2

        Label {
            Layout.alignment: Qt.AlignRight  // выравнивание по правой стороне
            text: qsTr("Название марки:")
        }
        TextField {
            id: textName
            Layout.fillWidth: true
            placeholderText: qsTr("Введите название")
        }
        Label {
            Layout.alignment: Qt.AlignRight
            text: qsTr("Страна:")
        }
        TextField {
            id: textCountry
            Layout.fillWidth: true
            placeholderText: qsTr("Введите страну")
        }
        Label {
            Layout.alignment: Qt.AlignRight
            text: qsTr("Год выпуска:")
        }
        TextField {
            id: textYear
            Layout.fillWidth: true
            placeholderText: qsTr("Введите год выпуска")
        }
        Label {
            Layout.alignment: Qt.AlignRight
            text: qsTr("Тираж:")
        }
        TextField {
            id: textCirculation
            Layout.fillWidth: true
            placeholderText: qsTr("Введите тираж")
        }
    }

    Button {
        anchors { right: buttonCancel.left; verticalCenter: buttonCancel.verticalCenter; rightMargin: 10 }
        text: qsTr("ОК")
        width: 100
        onClicked: {
            root.hide()
            if (currentIndex<0)
            {
                add(textName.text, textCountry.text, textYear.text, textCirculation.text)
            }
            else
            {
                edit(textName.text, textCountry.text, textYear.text, textCirculation.text, root.currentIndex)
            }

        }
    }

    Button {
        id: buttonCancel
        anchors { right: parent.right; bottom: parent.bottom; rightMargin: 10; bottomMargin: 10 }
        text: qsTr("Отменить")
        width: 100
        onClicked: {
             root.hide()
        }
    }

    // изменение статуса видимости окна диалога
    onVisibleChanged: {
      if (visible && currentIndex < 0) {
          textName.text = ""
          textCountry.text = ""
          textYear.text = ""
          textCirculation.text = ""
      }
    }

    function execute(name, country, year, circulation, index){
        isEdit = true
        textName.text = name
        textCountry.text = country
        textYear.text = year
        textCirculation.text = circulation
        root.currentIndex = index

        root.show()
    }


 }
