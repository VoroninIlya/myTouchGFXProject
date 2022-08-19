#ifndef TOUCH_CALLIBPRESENTER_HPP
#define TOUCH_CALLIBPRESENTER_HPP

#include <gui/model/ModelListener.hpp>
#include <mvp/Presenter.hpp>

using namespace touchgfx;

class touch_callibView;

class touch_callibPresenter : public touchgfx::Presenter, public ModelListener
{
public:
    touch_callibPresenter(touch_callibView& v);

    /**
     * The activate function is called automatically when this screen is "switched in"
     * (ie. made active). Initialization logic can be placed here.
     */
    virtual void activate();

    /**
     * The deactivate function is called automatically when this screen is "switched out"
     * (ie. made inactive). Teardown functionality can be placed here.
     */
    virtual void deactivate();

    virtual ~touch_callibPresenter() {};

private:
    touch_callibPresenter();

    touch_callibView& view;
};

#endif // TOUCH_CALLIBPRESENTER_HPP
