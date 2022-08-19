#ifndef TERMINALVIEW_HPP
#define TERMINALVIEW_HPP

#include <gui_generated/terminal_screen/TerminalViewBase.hpp>
#include <gui/terminal_screen/TerminalPresenter.hpp>

class TerminalView : public TerminalViewBase
{
public:
    TerminalView();
    virtual ~TerminalView() {}
    virtual void setupScreen();
    virtual void tearDownScreen();
protected:
};

#endif // TERMINALVIEW_HPP
