import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 2.5  // это версия библиотеки, содержащей Contol (аналоги виджетов) для версии Qt 5.6
import QtQuick.Layouts 1.2


Window {
    visible: true
    width: 700
    height: 480
    title: qsTr("СПРАВОЧНИК ФИЛАТЕЛИСТА")

    // объявляется системная палитра
    SystemPalette {
          id: palette;
          colorGroup: SystemPalette.Active
       }

    Rectangle{
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottom: btnAdd.top
        anchors.bottomMargin: 8
        border.color: "gray"
    ScrollView {
        anchors.fill: parent
        //flickableItem.interactive: true  // сохранять свойство "быть выделенным" при потере фокуса мыши
        Text {
            anchors.fill: parent
            text: "Could not connect to SQL"
            color: "red"
            font.pointSize: 20
            font.bold: true
            visible: IsConnectionOpen == false
        }
        ListView {
            id: philList
            anchors.fill: parent
            model: philatelistModel // назначение модели, данные которой отображаются списком
            delegate: DelegateForPhilatelist{}
            clip: true //
            activeFocusOnTab: true  // реагирование на перемещение между элементами ввода с помощью Tab
            focus: true  // элемент может получить фокус
            opacity: {if (IsConnectionOpen == true) {100} else {0}}
        }



    }
   }

    Button {
        id: btnAdd
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8
        anchors.rightMargin: 8
        anchors.right:btnEdit.left
        text: "Добавить"
        width: 100

        onClicked: {
            windowAddEdit.currentIndex = -1
            windowAddEdit.show()
        }
    }

    Button {
        id: btnEdit
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8
        anchors.right: btnDel.left
        anchors.rightMargin: 8
        text: "Редактировать"
        width: 100
        onClicked: {
            var namePh = philList.currentItem.personData.NameBrand
            var countryPh = philList.currentItem.personData.Country
            var yearPh = philList.currentItem.personData.Year
            var circulationPh = philList.currentItem.personData.Circulation
            var elementID = philList.currentItem.personData.Id_phil

            windowAddEdit.execute(namePh, countryPh, yearPh, circulationPh, elementID)
        }
    }

    Button {
        id: btnDel
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8
        anchors.right:parent.right
        anchors.rightMargin: 8
        text: "Удалить"
        width: 100
        enabled: {
            if (philList.currentItem==null || philList.currentItem.personData == null)
            {false}
            else
            {philList.currentItem.personData.Id_phil >= 0} }
        onClicked: del(philList.currentItem.personData.Id_phil)
    }

    Label {
            id: labelArea
            // Устанавливаем расположение надписи
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 12
            anchors.left: parent.left
            anchors.rightMargin: 8
            anchors.leftMargin: 8
            // Выравниваем по правой стороне
            Layout.alignment: Qt.AlignRight
            // Настраиваем текст
            text: qsTr("Подсчёт кол-ва записей:")
        }

    TextField {
            id: textSelCount
            Layout.fillWidth: true
            // Устанавливае что может быть введено в поле
            validator: IntValidator {bottom: 0;}
            // Позволяет установить текст до ввода информации
            placeholderText: qsTr("Введите тираж марок")
            // Устанавливаем расположение кнопки
            anchors.bottom: parent.bottom
            width: 130
            anchors.bottomMargin: 10
            anchors.leftMargin: 8
            anchors.left: labelArea.right
            anchors.rightMargin: 8
        }

        Button {
            id: butCount
            // Устанавливаем расположение кнопки
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 8
            anchors.left: textSelCount.right
            anchors.leftMargin: 8
            // Устанавливаем текст
            text: "OK"
            // Устанавливаем ширину кнопки
            width: 50
            // Указываем условие при котором эта кнопка будет активна
            enabled: textSelCount.text != ""
            // Устанавливаем функцию
            onClicked: {
                windowCount.countMark(textSelCount.text)
            }
        }

    DialogForAddorEdit {
        id: windowAddEdit
    }

    DialogForCount{
        id: windowCount
    }
}
