import QtQuick 2.6
import QtQuick.Controls 2.5  // это версия библиотеки, содержащей Contol (аналоги виджетов) для версии Qt 5.6
import QtQuick.Layouts 1.2

Rectangle {
    id: philItem
    readonly property color evenBackgroundColor: "#f9f9f9"  // цвет для четных пунктов списка
    readonly property color oddBackgroundColor: "#ffffff"   // цвет для нечетных пунктов списка
    readonly property color selectedBackgroundColor: "#eaf1f7"  // цвет выделенного элемента списка

    property bool isCurrent: philItem.ListView.view.currentIndex === index   // назначено свойство isCurrent истинно для текущего (выделенного) элемента списка
    property bool selected: philItemMouseArea.containsMouse || isCurrent // назначено свойство "быть выделенным",
    //которому присвоено значение "при наведении мыши,
    //или совпадении текущего индекса модели"

    property variant personData: model // свойство для доступа к данным конкретного студента

    width: parent ? parent.width : philList.width
    height: 90

    // состояние текущего элемента (Rectangle)
    states: [
        State {
            when: selected
            // как реагировать, если состояние стало selected
            PropertyChanges { target: philItem;  // для какого элемента должно назначаться свойство при этом состоянии (selected)
                color: isCurrent ? palette.highlight : selectedBackgroundColor  /* какое свойство целевого объекта (Rectangle)
                                                                                                  и какое значение присвоить*/
            }
        },
        State {
            when: !selected
            PropertyChanges { target: philItem;  color: isCurrent ? palette.highlight : index % 2 == 0 ? evenBackgroundColor : oddBackgroundColor }
        }
    ]

    MouseArea {
        id: philItemMouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            philItem.ListView.view.currentIndex = index
            philItem.forceActiveFocus()
        }
    }
    Item {
        id: itemOfPhilatelist
        width: parent.width
        height: 90
        Column{
            id: t2
            anchors.left: parent.left
            anchors.leftMargin: 10
            width: 240
            anchors.verticalCenter: parent.verticalCenter
            Text {
                id: t1
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Название марки:"
                color: "black"
                font.pointSize: 12
            }
            Text {
                id: textName
                anchors.horizontalCenter: parent.horizontalCenter
                text: NameBrand
                color: "purple"
                font.pointSize: 18
                font.bold: true
            }
        }

        Row{
            anchors.left: t2.right
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            Text {

                text: "Страна: "
                color: "black"
                font.pointSize: 12
            }
            Text {
                id: textCountry
                text: Country
                color: "purple"
                font.pointSize: 12
            }
            Text {
                text: "  "
                font.pointSize: 15
            }
            Text {

                text: "Год выпуска: "
                color: "black"
                font.pointSize: 12
            }
            Text {
                id: textYear
                color: "purple"
                text: Year
                font.pointSize: 12
            }
            Text {
                text: "  "
                font.pointSize: 15
            }
            Text {

                text: "Тираж: "
                color: "black"
                font.pointSize: 12
            }
            Text {
                id: textCirculation
                color: "purple"
                text: Circulation
                font.pointSize: 12
            }
        }

    }
}
