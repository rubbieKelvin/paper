"""
checklist mananger
"""
import sys
from PySide2 import QtWidgets


class Paper(QtWidgets.QMainWindow):
    def __init__(self):
        super().__init__()
        self.init_ui()

    def init_ui(self):
        self.setWindowTitle('paper')
        self.show()

def main():
    app = QtWidgets.QApplication(sys.argv)
    main_window = Paper()
    sys.exit(app.exec_())
