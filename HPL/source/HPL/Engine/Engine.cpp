#include "hplpch.hpp"
#include "HPL/Engine/Engine.hpp"


namespace hpl
{
    cEngine::cEngine()
    {
    }

    cEngine::~cEngine()
    {
    }

    void cEngine::Run()
    {
        while (!IsGameDone())
        {
            if (IsPaused())
            {

            }
            else
            {

            }
        }
    }

    void cEngine::Exit()
    {
    }

    bool cEngine::IsPaused()
    {
        bool paused = m_paused;
        return paused;
    }

    bool cEngine::IsGameDone()
    {
        bool done = m_gameIsDone;
        return done;
    }
}