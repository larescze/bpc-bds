import { createStore } from "vuex";

interface Auth {
    token: string | null,
    isAuthenticated: boolean
}

export default createStore({
    state: {
        token: '',
        isAuthenticated: false
    },
    mutations: {
        initializeStore(state: Auth): void {
            if (localStorage.getItem('token')) {
                state.token = localStorage.getItem('token');
                state.isAuthenticated = true;
            } else {
                state.token = '';
                state.isAuthenticated = false;
            }
        },
        setToken(state, token): void {
            state.token = token;
            state.isAuthenticated = true;
        },
        removeToken(state: Auth): void {
            state.token = '';
            state.isAuthenticated = false;
            localStorage.removeItem("token");
        }
    },
    actions: {
        //
    },
    modules: {
        //
    }
})