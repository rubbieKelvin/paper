import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.11
import '../components/' as UiComponents

Page{
    title: "Home"

    RowLayout{
        anchors.fill: parent
        spacing: 0

        // SIDE
        Rectangle {
            Layout.preferredWidth: 250
            Layout.fillHeight: true
            color: "transparent"

            ColumnLayout{
                anchors.fill: parent
                spacing: 10
                anchors.margins: 12

                RowLayout{
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    spacing: 8

                    Image{
                        width: 121
                        height: 19
                        Layout.fillWidth: true
                        fillMode: Image.PreserveAspectFit
                        source: "../assets/brand.svg"
                    }

                    UiComponents.Icon{
                        path: "M12.0181 7.02527H15.6396L7 15.5L6.98193 8.97473H10.9819V6.97473H4.98193V18.9747H16.9819V12.9747H14.9819V16.9747L8.5 17L17.0181 8.47528V12.0253H19.0181V5.02527H12.0181V7.02527Z"
                    }
                }


                ListView{
                    id: checklist_list
					Layout.fillHeight: true
					Layout.fillWidth: true
					model: 7
					spacing: 5
					delegate: UiComponents.CheckListItemDelegate{
						width: parent.width
                        highlighted: checklist_list.currentItem === this;
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                const x = parent.x;
                                const y = parent.y;
                                const index = checklist_list.indexAt(x, y);
                                checklist_list.currentIndex = index;
                            }
                        }
					}
					highlight: Rectangle{color: pallete.alphaprimary; radius: 5}
				}

            }
        }

        // LINE
        Rectangle{
            Layout.preferredWidth: 1
            Layout.fillHeight: true
            color: "#dfdfdf"
        }

        Rectangle{
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "transparent"
        }
    }
}
/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.8999999761581421;height:480;width:640}
}
##^##*/
