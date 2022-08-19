#ifndef TOUCH_CALLIBVIEW_HPP
#define TOUCH_CALLIBVIEW_HPP

#include <gui_generated/touch_callib_screen/touch_callibViewBase.hpp>
#include <gui/touch_callib_screen/touch_callibPresenter.hpp>

class touch_callibView : public touch_callibViewBase
{
public:
    touch_callibView();
    virtual ~touch_callibView() {}
    virtual void setupScreen();
    virtual void tearDownScreen();
protected:
};

#endif // TOUCH_CALLIBVIEW_HPP
