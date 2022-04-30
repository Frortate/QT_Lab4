import QtQuick 6.0
import QtQuick.Window 6.0
import QtQuick.Controls 6.0   // это версия библиотеки, содержащей Contol (аналоги виджетов) для версии Qt 5.6
import QtQuick.Layouts 6.0

Window {
    id: root
    modality: Qt.ApplicationModal
    title: qsTr("Подсчёт кол-ва марок")
    width: 300
    height: 60

    GridLayout{
        anchors {
            left: parent.left;
            top: parent.top;
            right: parent.right
            margins: 10
        }

        columns: 2

        Label{
            Layout.alignment: Qt.AlignCenter
            text: qsTr("Кол-во марок = ")
        }

        Label {
            id: textResult
            Layout.fillWidth:  true
        }
    }

    function countMark(textCount){
        textResult.text = count(textCount);
        root.show()
    }


}
