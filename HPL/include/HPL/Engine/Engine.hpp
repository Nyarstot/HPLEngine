#ifndef HPL_ENGINE_ENGINE_HPP
#define HPL_ENGINE_ENGINE_HPP


namespace hpl
{
    class cEngine
    {
    private:
        bool m_gameIsDone;
        bool m_paused;

    public:
        cEngine();
        ~cEngine();

        void Run();
        void Exit();

        bool IsGameDone();
        bool IsPaused();

    };

    extern int hplMain();
}

#endif // !HPL_ENGINE_ENGINE_HPP
